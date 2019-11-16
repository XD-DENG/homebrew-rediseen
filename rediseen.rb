class Rediseen < Formula
  desc "Start REST API service for Redis without writing a single line of code"
  homepage "https://github.com/XD-DENG/rediseen"
  url "https://github.com/XD-DENG/rediseen/archive/1.4.0.tar.gz"
  sha256 "74e801aaee3e3667404161c73a806a3e158cb3476f8f0b373280bf6cfba5c4dc"

  head do
    url "https://github.com/XD-DENG/rediseen.git"
  end
  depends_on "go" => :build

  def install
    system "go", "build", "-o", "#{bin}/#{name}"
  end

  test do
    assert_match "1.4.0", shell_output("#{bin}/#{name} version").strip
    assert_match "[ERROR] No valid Redis URI is provided",
                 shell_output("#{bin}/#{name} start")
    assert_match "REDISEEN_DB_EXPOSED is not configured",
                 shell_output("export REDISEEN_REDIS_URI=redis://:@localhost:6379;" \
                              "#{bin}/#{name} start")
    assert_match "[ERROR] You have not specified any key pattern to allow being accessed",
                 shell_output("export REDISEEN_REDIS_URI=redis://:@localhost:6379;" \
                              "export REDISEEN_DB_EXPOSED=0;" \
                              "#{bin}/#{name} start")
    assert_match "[ERROR] Initial talking to Redis failed. Please check the URI provided.",
                 shell_output("export REDISEEN_REDIS_URI=redis://:@localhost:8888;" \
                              "export REDISEEN_DB_EXPOSED=0;" \
                              "export REDISEEN_KEY_PATTERN_EXPOSE_ALL=true;" \
                              "#{bin}/#{name} start")
  end
end
