class Gdc < Formula
  desc "GPL implementation of the D compiler which integrates the open source D front end with GCC."
  homepage "http://gdcproject.org/"
  head "https://github.com/D-Programming-GDC/GDC.git", :branch => "gdc-5"

  depends_on "gmp"
  depends_on "libmpc"
  depends_on "mpfr"
  depends_on "isl"

  resource "gcc-source" do
    url "http://ftpmirror.gnu.org/gcc/gcc-5.2.0/gcc-5.2.0.tar.bz2"
    mirror "https://ftp.gnu.org/gnu/gcc/gcc-5.2.0/gcc-5.2.0.tar.bz2"
    sha256 "5f835b04b5f7dd4f4d2dc96190ec1621b8d89f2dc6f638f9f8bc1b1014ba8cad"
  end

  def install
    args = [
      "--enable-languages=d",
      "--disable-bootstrap",
      "--prefix=/opt/gdc",
      "--enable-checking=yes",
      "--prefix=#{prefix}",
      "--with-gmp=#{Formula["gmp"].opt_prefix}",
      "--with-mpfr=#{Formula["mpfr"].opt_prefix}",
      "--with-mpc=#{Formula["libmpc"].opt_prefix}",
      "--with-isl=#{Formula["isl"].opt_prefix}"
    ]

    (buildpath/"gcc-source").install resource("gcc-source")

    system "./setup-gcc.sh", "gcc-source"

    mkdir "objdir" do
      system "../gcc-source/configure", *args
      system "make"
      system "make", "install"
    end
  end
end
