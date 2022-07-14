#include "CFE_SPIRV_Compiler.hpp"
#include <clang/Basic/Diagnostic.h>
#include <clang/Basic/DiagnosticIDs.h>
#include <clang/Basic/DiagnosticOptions.h>
#include <clang/Basic/FileManager.h>
#include <clang/Driver/Compilation.h>
#include <clang/Driver/Driver.h>
SPIRV_Compiler::SPIRV_Compiler(const std::string& kernel_file, const std::string& output_file): kernel_file(kernel_file), output_file(output_file)
{
  auto cPath = llvm::sys::findProgramByName("clang++");
  if (!cPath) {
    llvm::errs() << "clang++ not found.\n";
    exit(1);
  }

  llvm::IntrusiveRefCntPtr<clang::DiagnosticsEngine> DE(
      clang::CompilerInstance::createDiagnostics(new clang::DiagnosticOptions));
  clangPath = cPath.get();
  llvm::ArrayRef
  driver = std::make_unique<clang::driver::Driver>(
      clangPath.c_str(), llvm::sys::getDefaultTargetTriple(),*DE,
      "Clang LLVM Compiler");
}

void SPIRV_Compiler::add_preprocessor_definitions(
    const std::vector<const char *> &definitions) {
  for (auto def : definitions) {
    preprocessorDefinitions.push_back("-D");
    preprocessorDefinitions.push_back(def);
  }
}

void SPIRV_Compiler::add_include_directories(
    const std::vector<const char *> &directories) {
  for (auto &dir : directories) {
    includeDirectories.push_back("-I");
    includeDirectories.push_back(dir);
  }
}

void SPIRV_Compiler::add_compile_options(
    const std::vector<const char *> &options) {
  for (auto &option : options) {
    compileOptions.push_back(option);
  }
}

void SPIRV_Compiler::emit_llvm() {
  std::vector<const char *> emit_args = {clangPath.c_str(), "-emit-llvm"};
  emit_args.insert(emit_args.end(), compileOptions.begin(),
                   compileOptions.end());
  emit_args.insert(emit_args.end(), includeDirectories.begin(), includeDirectories.end());
  emit_args.insert(emit_args.end(), preprocessorDefinitions.begin(),
                   preprocessorDefinitions.end());
  build_execute(emit_args);
}

void SPIRV_Compiler::compile() 
{
  std::vector<const char *> compile_args = {clangPath.c_str()};
  compile_args.insert(compile_args.end(), compileOptions.begin(),
                   compileOptions.end());
  compile_args.insert(compile_args.end(), includeDirectories.begin(), includeDirectories.end());
  compile_args.insert(compile_args.end(), preprocessorDefinitions.begin(),
                   preprocessorDefinitions.end());
  build_execute(compile_args);
}

void SPIRV_Compiler::build_execute(const std::vector<const char*>& args) {
  std::unique_ptr<clang::driver::Compilation> compilation(
      driver->BuildCompilation(llvm::ArrayRef<const char *>(args)));
  assert(compilation > 0);
  const clang::driver::JobList &Jobs = compilation->getJobs();
  const clang::driver::Command *FailingCmd = nullptr;
  for (auto& job : Jobs.getJobs()) {
    compilation->ExecuteCommand(*job, FailingCmd);
    if (FailingCmd) {
      llvm::errs() << "Error: Command " << FailingCmd
                   << " failed.\n";
    }
  }
}
