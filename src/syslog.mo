import SWB "mo:swbstable/Stable";
import Time "mo:base/Time";
import Array "mo:base/Array";
import Int "mo:base/Int";

module {
    public type Mem = {
        main : SWB.StableData<Text>;
    };

    public func Mem() : Mem {
        {
            main = SWB.SlidingWindowBufferNewMem<Text>()
        }
    };

    public class SysLog({
        mem : Mem;
    }) { 

        let ev = SWB.SlidingWindowBuffer<Text>(mem.main);

        public func add(e: Text) {
            ignore ev.add(Int.toText(Time.now()) # " : " # e);
            if (ev.len() > 1000) { // Max 1000
                ev.delete(1); // Delete 1 element from the beginning
            };
        };

        public func get() : [?Text] {
          let start = ev.start();

          Array.tabulate(
                ev.len(),
                func(i : Nat) : ?Text {
                    ev.getOpt(start + i);
                },
            );
        };

    }
}