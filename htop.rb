class Htop < Formula
  desc "Interactive text-mode process viewer. A better 'top'."
  homepage "http://hisham.hm/htop/"
  head "https://github.com/hishamhm/htop.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  def caveats; <<-EOS.undent
    htop requires root privileges to correctly display all running processes.
    so you will need to run `sudo htop`.
    You should be certain that you trust any software you grant root privileges.
    EOS
  end

  test do
    pipe_output("#{bin}/htop", "q")
    assert $?.success?
  end
end
