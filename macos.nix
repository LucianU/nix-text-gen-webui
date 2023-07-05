{ lib
, python3
, fetchFromGitHub
}:
let
  gradio = python3.pkgs.callPackage ./pkgs/common/gradio.nix { };
  flexgen = python3.pkgs.callPackage ./pkgs/common/flexgen.nix { };
  peft = python3.pkgs.callPackage ./pkgs/common/peft.nix { };
  llama-cpp-python = python3.pkgs.callPackage ./pkgs/common/llama-cpp-python.nix { };
in
python3.pkgs.buildPythonApplication rec {
  pname = "text-generation-webui";
  version = "e0a50fb";

  src = fetchFromGitHub {
    owner = "oobabooga";
    repo = "text-generation-webui";
    rev = version;
    hash = "sha256-18+Ed2+oNsPDT9VZgCCpXFW9TEokhJpoQzTVllCS7Jw=";
  };

  propagatedBuildInputs = with python3.pkgs; [
    accelerate
    colorama
    datasets
    einops
    flexgen
    markdown
    numpy
    pandas
    pillow
    pyyaml
    requests
    safetensors
    sentencepiece
    tqdm
    scipy
    transformers
    peft
    llama-cpp-python
    gradio
    torch
    torchaudio
    torchvision
  ];

  meta = with lib; {
    description = "A gradio web UI for running Large Language Models like LLaMA, llama.cpp, GPT-J, Pythia, OPT, and GALACTICA";
    homepage = "https://github.com/oobabooga/text-generation-webui";
    license = licenses.agpl3Only;
    maintainers = with maintainers; [ ];
  };
}
