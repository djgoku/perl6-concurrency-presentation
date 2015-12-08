use v6;
# https://rt.perl.org/Public/Bug/Display.html?id=124071

sub worker(Channel $in, Int $str) {
    my $closed = $in.closed;
    loop {
        if $in.poll -> $item {
            say "received: ", $item, " for $str";
        }
        elsif $closed {
            last;
        }
    }
}

my $channel = Channel.new;

my @workers;

await (^100).map: -> $r {
    start {
        $channel.send($r);
    }
}

for (^5) -> $i {
    push @workers, start { worker($channel, $i) };
}

$channel.close;

await @workers;
