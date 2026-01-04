{ pkgs ? import <nixpkgs> {} }:
let
message = "hi";
in
pkgs.mkShell{

	name = "buildResume";


	buildInputs = [ pkgs.texliveFull pkgs.poppler-utils];



	shellHook = ''
	ls -al
	pwd
	'';


}
