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
      sha256 "5cb1009df91f624528eae00b73d0323d493799b0"
    end

    on_intel do
      url "https://github.com/browserup/homebrew-browserup-cli/releases/download/0.0.6/browserup.0.0.6.tar.gz"
      sha256 "0ebc4006c303efe7e3185ba4536bee8b4267d4ba593e537dd260170631d05e08"
    end
  end

  on_linux do
    url "https://github.com/browserup/homebrew-browserup-cli/releases/download/0.0.6/browserup.0.0.6.tar.gz"
    sha256 "0ebc4006c303efe7e3185ba4536bee8b4267d4ba593e537dd260170631d05e08"
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
