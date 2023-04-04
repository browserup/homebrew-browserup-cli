# Documentation: https://docs.brew.sh/Formula-Cookbook and https://rubydoc.brew.sh/Formula

class BrowserupCli < Formula
  desc "Browserup CLI Application For Load Testing"
  homepage "https://browserup.com"

  # https://docs.brew.sh/Formula-Cookbook#handling-different-system-configurations
  on_macos do
    # See https://projects.laas.fr/tina/howto-arm64-darwin.html and
    # https://projects.laas.fr/tina/software.php
    on_arm do
      url "https://github.com/browserup/homebrew-browserup-cli/releases/download/0.1.0/browserup-arm64.0.1.0.tar.gz"
      sha256 "e7e5293f2be6bd09dceddd26e8df2ecfecad505d44557fd570af7b786af604c6"
    end

    on_intel do
      url "https://github.com/browserup/homebrew-browserup-cli/releases/download/0.1.0/browserup-amd64.0.1.0.tar.gz"
      sha256 "ba2b6da4daa2f957e3b65565e8a6c02e20c93e4eb519feffc5ca665b9eb2e583"
    end
  end

  on_linux do
    url "https://github.com/browserup/homebrew-browserup-cli/releases/download/0.1.0/browserup-linux-amd64.0.1.0.tar.gz"
    sha256 "a40a69cf3db38def1dd345c1ec3aa352e401f367f00c6fd0e25be40d74c05069"
  end

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    # system "./configure", *std_configure_args, "--disable-silent-rules"
    # system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    bin.install "browserup"
    bin.install Dir["lib"]
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test homebrew-browserup-cli`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    result = system "#{bin}/browserup help"
    assert result.include?('browserup')
  end


end
