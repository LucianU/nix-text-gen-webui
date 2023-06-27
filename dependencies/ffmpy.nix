{ lib
, buildPythonPackage
, fetchFromGitHub
}:

buildPythonPackage rec {
  pname = "ffmpy";
  version = "unstable-2022-05-27";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "Ch00k";
    repo = "ffmpy";
    rev = "1d54be12323d5ffc247e08051a53864d966732ca";
    hash = "sha256-WvLngYDh+QWNROVdWoYSfAa3w3o9cYTbSbaSF+a2h/8=";
  };

  pythonImportsCheck = [ "ffmpy" ];

  meta = with lib; {
    description = "Pythonic interface for FFmpeg/FFprobe command line";
    homepage = "https://github.com/Ch00k/ffmpy";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
