use v6;

#`(
	This script dynamically creates a semi-random set of files contain JSON
	blobs of text.
)

my @output;

my @files = (1..100).pick((25).pick());
say "files ", @files, ' with a size of ', @files.elems;

for @files -> $file {
	my $f = "file$file.txt";
	"Outputting file $f".say;

	my %h;

	for (1..100).pick((1..25).pick()) {
		%h{"test$_"} = $_;
	}

	push @output, start {
		my $json = to-json(%h);
		spurt $f, $json;
	}
}

my $all-successful = Promise.allof(@output);
await $all-successful;
say $all-successful;