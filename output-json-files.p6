use v6;

my %json = 
	'file1.txt'=> {
		'test1'=> 1,
		'test2'=> 2,
		'test3'=> 3,
	}, 'file2.txt' => {
		'test1'=> 3,
		'test2'=> 2,
		'test3'=> 1,
	}, 'file3.txt' => {
		'test1'=> 2,
		'test2'=> 3,
		'test3'=> 1,
	};

my @output;

for %json.kv -> $key, $value {
	"Outputting file $key".say;
	push @output, start {
		my $json = to-json($value);
		spurt $key, $json;
	}
}

my $all-successful = Promise.allof(@output);
await $all-successful;
say $all-successful;