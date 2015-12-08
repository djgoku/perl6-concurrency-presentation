use v6;

my @args = @*ARGS;

if @args.elems == 0 {
	"no files passed in through \@args".say;
	exit;
}

@args := @args.rotate((1 .. @args.elems.pick).pick);

my @file_handles;

for @args -> $arg {
	my $file = $arg.IO;
	if $file ~~ :e and $file ~~ :f {
		@file_handles.append($file);
	}
}

my @promises;
for @file_handles -> $file {
	push @promises, start {
		from-json(slurp($file));
	}
}

my $all-successful = Promise.allof(@promises);
await $all-successful;
say $all-successful;

my @results;
for @promises -> $promise {
	say "result: ", $promise.result;
	push @results, $promise.result;

	CATCH {
		default { say "failure: ", $promise.cause; }
	}
}

my %hash;
for @results -> $result {
	%hash.append(%$result);
}

for %hash.kv -> $key, $value {
	say "for $key total is: ", [+] $value;
}