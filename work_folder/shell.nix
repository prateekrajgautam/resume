{ pkgs ? import <nixpkgs> {} }:
let
message = "hi";
in
pkgs.mkShellNoCC{

	name = "buildResume";


	buildInputs = [ pkgs.vscodium pkgs.texliveFull pkgs.poppler_utils];



	shellHook = ''
	./compileAll.sh
	'';


}
