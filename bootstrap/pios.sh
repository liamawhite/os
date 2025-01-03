#! /bin/sh

echo "Adding GitHub to known hosts..."
mkdir -p ~/.ssh || { echo "Failed to create .ssh directory"; exit 1; }
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts || { echo "Failed to add GitHub to known hosts"; exit 1; }

tmpdir=$(mktemp -d) || { echo "Failed to create temporary directory"; exit 1; }
echo "Cloning into temporary directory: $tmpdir"
git clone https://github.com/liamawhite/os.git "$tmpdir" || { echo "Failed to clone repository"; exit 1; }

echo "Switching to initial generation..."
cd "$tmpdir" || { echo "Failed to change to temporary directory"; exit 1; }
home-manager switch --flake . || { echo "Failed to switch to initial generation"; exit 1; }
