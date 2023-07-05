{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools
, wheel
}:

buildPythonPackage rec {
  pname = "sse-starlette";
  version = "1.6.1";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "sysid";
    repo = "sse-starlette";
    rev = "v${version}";
    hash = "sha256-b96J+P0X/4oxEZf6X58lUhExF2DapDn1EdxXIUbqrhs=";
  };

  nativeBuildInputs = [
    setuptools
    wheel
  ];

  pythonImportsCheck = [ "sse_starlette" ];

  meta = with lib; {
    description = "";
    homepage = "https://github.com/sysid/sse-starlette";
    changelog = "https://github.com/sysid/sse-starlette/blob/${src.rev}/CHANGELOG.md";
    license = licenses.bsd3;
    maintainers = with maintainers; [ ];
  };
}
