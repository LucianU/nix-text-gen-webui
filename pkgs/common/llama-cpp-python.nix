{ lib
, callPackage
, buildPythonPackage
, fetchFromGitHub
, cmake
, ninja
, poetry-core
, scikit-build
, setuptools
, diskcache
, numpy
, typing-extensions
, fastapi
, uvicorn
}:
let
  sse-starlette = callPackage ./sse-starlette.nix { };
in
buildPythonPackage rec {
  pname = "llama-cpp-python";
  version = "a1b2d5c";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "abetlen";
    repo = "llama-cpp-python";
    rev = "v${version}";
    hash = "sha256-zsoQbmlRv6ISUzKXlIHvI9k5Oli/kt3s42n50f8C1IY=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    cmake
    ninja
    poetry-core
    scikit-build
    setuptools
  ];

  propagatedBuildInputs = [
    diskcache
    numpy
    typing-extensions
  ];

  passthru.optional-dependencies = {
    server = [
      fastapi
      sse-starlette
      uvicorn
    ];
  };

  pythonImportsCheck = [ "llama_cpp" ];

  meta = with lib; {
    description = "Python bindings for llama.cpp";
    homepage = "https://github.com/abetlen/llama-cpp-python";
    changelog = "https://github.com/abetlen/llama-cpp-python/blob/${src.rev}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
