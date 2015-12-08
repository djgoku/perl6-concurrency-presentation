Channel
* A Channel is a thread-safe queue that can have multiple readers and writers that could be considered to be similar in operation to a "fifo" or named pipe except it does not enable inter-process communication.


Supplier
* A Supply is an asynchronous data streaming mechanism that can be consumed by one or more consumers simultaneously in a manner similar to "events" in other programming languages and can be seen as enabling "Event Driven" or reactive designs.
* example

my $supplier = Supplier.new;
my $supply   = $supplier.Supply;

$supply.tap( -> $v { say $v });

for 1 .. 10 {
    $supplier.emit($_);
}


Promise:
* A Promise (also called future in other programming environments) encapsulates the result of a computation that may not have completed or even started at the time the promise is obtained. It provides much of the functionality that user code needs to operate in a concurrent or asynchronous manner.

* use Promise.then() to execute when promise has been kept/broken.
* Simple example:
my $p1 = Promise.new;
say $p1.status;         # Planned;
$p1.keep('result');
say $p1.status;         # Kept
say $p1.result;         # result

my $p2 = Promise.new;
$p2.break('oh no');
say $p2.status;         # Broken
say $p2.result;         # dies with "oh no"

http://doc.perl6.org/type/Promise
http://doc.perl6.org/language/concurrency#Promises

http://doc.perl6.org/language/concurrency
http://jnthn.net/papers/2015-yapcasia-concurrency.pdf
https://learnxinyminutes.com/docs/perl6/
http://doc.perl6.org/routine/spurt#role_IO
