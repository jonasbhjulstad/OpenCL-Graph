#ifndef CFE_SPIRV_COMPILER_HPP
#define CFE_SPIRV_COMPILER_HPP
#include <clang/Driver/Driver.h>
#include <clang/Frontend/CompilerInstance.h>
#include <llvm/Support/FileSystem.h>
#include <llvm/Support/Host.h>
#include <llvm/Support/Program.h>
#include <llvm/Support/VirtualFileSystem.h>

//Clang Compiler Frontend SPIRV-Toolchain Compiler abstraction
class SPIRV_Compiler {
  clang::CompilerInstance CI;
  std::unique_ptr<clang::driver::Driver> driver;
  std::unique_ptr<llvm::raw_pwrite_stream> outputFile;
  std::string clangPath;
  std::vector<const char *> preprocessorDefinitions;
  std::vector<const char *> includeDirectories;
  std::vector<const char *> compileOptions = {"-c", "-cl-std=clc++2021"};
  std::string kernel_file;
  std::string output_file;

public:
  SPIRV_Compiler(const std::string &kernel_file,
                 const std::string &output_file);

  void
  add_preprocessor_definitions(const std::vector<const char *> &definitions);

  void add_include_directories(const std::vector<const char *> &directories);

  void add_compile_options(const std::vector<const char *> &options);

  void emit_llvm();

  void compile();

private:
  void build_execute(const std::vector<const char*>& args);

};

#endif