{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools
, attrs
, numpy
, pulp
, torch
, tqdm
, transformers
}:

buildPythonPackage rec {
  pname = "flexgen";
  version = "unstable-2023-06-11";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "FMInference";
    repo = "FlexGen";
    rev = "b80da06803f93195f5cf48516f28db790b6f85bd";
    hash = "sha256-I3BiR4Cr74TUL1OqFTB9TwRYzfZ41i2f4ZDI3Qe5OSU=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    attrs
    numpy
    pulp
    torch
    tqdm
    transformers
  ];

  pythonImportsCheck = [ "flexgen" ];

  meta = with lib; {
    description = "Running large language models on a single GPU for throughput-oriented scenarios";
    homepage = "https://github.com/FMInference/FlexGen";
    license = licenses.asl20;
    maintainers = with maintainers; [ ];
  };
}
