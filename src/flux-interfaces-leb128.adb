with System.Storage_Elements; use System.Storage_Elements;

package body Flux.Interfaces.LEB128 is

   ------------
   -- Encode --
   ------------

   procedure Encode (S       : in out Sink.Instance'Class;
                     Value   :        T;
                     Success :    out Boolean)
   is
      function Shift_Right
        (Value  : T;
         Amount : Natural) return T
      with Import, Convention => Intrinsic;

      B : Storage_Element;
      V : T := Value;
   begin
      loop
         B := Storage_Element (V and 16#FF#);
         V := Shift_Right (V, 7);

         if V /= 0 then
            B := B or 2#1000_0000#;
         end if;

         S.Write (B, Success);

         exit when not Success or else V = 0;
      end loop;

   end Encode;

   ------------
   -- Decode --
   ------------

   procedure Decode (S       : in out Seekable_Source.Instance'Class;
                     Value   : out T;
                     Success : out Boolean)
   is
      function Shift_Left
        (Value  : T;
         Amount : Natural) return T
        with Import, Convention => Intrinsic;

      Shift : Natural := 0;
      Offset : Storage_Count := 0;
      B : Storage_Element;
   begin

      Value := 0;
      loop
         S.Seek_Relative (Offset, B, Success);

         if not Success then
            return;
         end if;

         Value := Value or Shift_Left (T (B and 2#0111_1111#), Shift);

         exit when (B and 2#1000_0000#) = 0;

         Shift := Shift + 7;
         Offset := Offset + 1;
      end loop;

      S.Consume (Offset + 1);
   end Decode;

end Flux.Interfaces.LEB128;
