class Smimesign < Formula
  desc "S/MIME signing utility for use with Git"
  homepage "https://github.com/github/smimesign"
  url "https://github.com/github/smimesign/archive/v0.1.1.tar.gz"
  sha256 "cc33a5327de86425f7bbcbafaa9b0689da84c1925e387dac181f4a402ffbd759"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "1ff41bca0d768e6939c790b7f0cb01a22e15710f4a286b0aba1de3940e4f7d6a"
    sha256 cellar: :any_skip_relocation, big_sur:       "aa8df0fdb6acb090de4eacca0b1b83825b6fa594c7743981be42654fede1b797"
    sha256 cellar: :any_skip_relocation, catalina:      "abad2ebcdf7f1c0eb58badee31d787e9a986b99ea17e79013acfeb437a4537e9"
    sha256 cellar: :any_skip_relocation, mojave:        "56af904bbe4aa96d755ef99b67145ee20c57d0a0fc1681fe9c6333e19ce68be3"
    sha256 cellar: :any_skip_relocation, high_sierra:   "024a4963b723bd2ec94fde2a578cb80342f4837d9ec34158ae023479c4157f33"
  end

  depends_on "go" => :build
  depends_on :macos

  def install
    system "go", "build", *std_go_args, "-ldflags", "-X main.versionString=#{version}"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/smimesign --version")
    system "#{bin}/smimesign", "--list-keys"
    assert_match "could not find identity matching specified user-id: bad@identity",
      shell_output("#{bin}/smimesign -su bad@identity 2>&1", 1)
  end
end
