{ lib
, buildPythonPackage
, fetchFromGitHub
}:

buildPythonPackage rec {
  pname = "autogptq";
  version = "0.2.2";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "PanQiWei";
    repo = "AutoGPTQ";
    rev = "v${version}";
    hash = "sha256-KFgnVSOpx0qPAWHHGNLOYa8HB3nvFvfjzp21MHl0I7w=";
  };

  pythonImportsCheck = [ "autogptq" ];

  meta = with lib; {
    description = "An easy-to-use LLMs quantization package with user-friendly apis, based on GPTQ algorithm";
    homepage = "https://github.com/PanQiWei/AutoGPTQ/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
