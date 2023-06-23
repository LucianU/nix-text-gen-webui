{ lib
, python3
, fetchFromGitHub
}:

python3.pkgs.buildPythonPackage rec {
  pname = "peft";
  version = "unstable-2023-06-16";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "huggingface";
    repo = "peft";
    rev = "03eb378eb914fbee709ff7c86ba5b1d033b89524";
    hash = "sha256-bbuE2KSi7rAlkUkIIs1R7DK2HVva29SduKoaWXFEOQ0=";
  };

  propagatedBuildInputs = with python3.pkgs; [
    numpy
    packaging
    psutil
    pyyaml
    torch
    transformers
    accelerate
    safetensors
  ];

  pythonImportsCheck = [ "peft" ];

  meta = with lib; {
    description = "PEFT: State-of-the-art Parameter-Efficient Fine-Tuning";
    homepage = "https://github.com/huggingface/peft";
    license = licenses.asl20;
    maintainers = with maintainers; [ ];
  };
}
