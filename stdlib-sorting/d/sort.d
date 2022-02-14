module sort;

import std.stdio: writeln;
import std.random: uniform;
import std.algorithm: sort, SwapStrategy;
import std.datetime.stopwatch: StopWatch, AutoStart;

void main() {
	immutable size = 10_000_000;
	auto array = new int[size];

	// generate random numbers
	foreach(ref a; array) {
		a = uniform(0, size);
	}

	// measure execution time
	auto sw = StopWatch(AutoStart.no);
	sw.start();
	array.sort();
	sw.stop();

	// print the result
	auto duration = sw.peek.total!"msecs";
	writeln("done: ", duration, " msecs");
}
