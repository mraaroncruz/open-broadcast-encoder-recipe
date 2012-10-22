# System
default[:obe][:prefix] = "/usr/local"

# Git
default[:obe][:git][:directory] = "/usr/local/src"
default[:obe][:git][:branch] = "master"

# Client
default[:obe][:cli][:input] = "decklink"

default[:obe][:cli][:options] = {
  "card-idx" => 3,
  "video-format" => "pal"
}

default[:obe][:cli][:inputs] = {
  2 => "audio"
}

default[:obe][:cli][:stream_options] = [
  {
    "pid" => 1000,
    "vbv-maxrate" => 1700,
    "vbv-bufsize" => 1700,
    "bitrate" => 1700,
    "key_int" => 24,
    "bframes" => 3,
    "profile" => "high",
    "level" => 4,
    "format" => "avc",
    "threads" => 2,
    "aspect-ratio" => "16:9"
  },
  {
    "pid" => 1001,
    "bitrate" => 64,
    "format" =>"aac",
    "aac-profile" => "he-aac-v1",
    "aac-encap" => "adts"
  },
  {
    "pid" => 1002,
    "format" => "mp2",
    "bitrate" => 128
  }
]

default[:obe][:cli][:muxer_options] = {
  "pmt-pid" => 100,
  "ts-muxrate" => 2500000,
  "ts-type" => "dv"
}

default[:obe][:cli][:output] = "udp"

default[:obe][:cli][:output_options] = {
  "target" => "udp://232.40.3.2:2000?ttl=20"
}
