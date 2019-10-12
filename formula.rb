class Rediseen < Formula
  desc "Start a REST-like API for your existing Redis database, without writing a single line of code"
  homepage "https://github.com/XD-DENG/rediseen"
  url "git://github.com/XD-DENG/rediseen"
  version "1.0.0"
  sha256 ""

  depends_on "go" => :build

  def install
    system "go", "build", "-o", "#{bin}/#{name}"
  end

  test do
    system "#{bin}/#{name}", "version"
  end
end
