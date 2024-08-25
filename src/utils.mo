import Array "mo:base/Array";
import Principal "mo:base/Principal";
import Blob "mo:base/Blob";
import Nat8 "mo:base/Nat8";

module {

    public func callerSubaccount(p : Principal) : Blob {
        let a = Array.init<Nat8>(32, 0);
            let pa = Principal.toBlob(p);
            a[0] := Nat8.fromNat(pa.size());

            var pos = 1;
            for (x in pa.vals()) {
                    a[pos] := x;
                    pos := pos + 1;
                };

            Blob.fromArray(Array.freeze(a));
    };

}