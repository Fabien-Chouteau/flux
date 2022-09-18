with System.Storage_Elements; use System.Storage_Elements;

with Flux.Interfaces.Sink;
with Flux.Interfaces.Source;

package body Flux.Interfaces.Hexdump is

   function Shift_Right
     (Value  : Storage_Element;
      Amount : Natural) return Storage_Element
     with Import, Convention => Intrinsic;

   ------------
   -- Encode --
   ------------

   procedure Encode (Src     : in out Source.Instance'Class;
                     Dst     : in out Sink.Instance'Class;
                     Success :    out Boolean)
   is
      type UInt4 is mod 2**4;

      function To_Char (Val : Storage_Element) return Storage_Element;

      pragma Style_Checks ("M120");
      --  Hexdump format:
      --         57 69 6B 69 70 65 64 69 61 2C 20 74 68 65 20 66  Wikipedia, the f
      --  Hex  : ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      --  ASCII:                                                  ^^^^^^^^^^^^^^^^^

      Hex_Len   : constant := 3 * 16;
      ASCII_Len : constant := 1 + 16;
      Str : Storage_Array (1 .. Hex_Len + ASCII_Len + 1) :=
        (others => Storage_Element'Val (Character'Pos (' ')));
      UInt4_To_Char : constant array (UInt4) of Storage_Element
        := (0 =>  Storage_Element'Val (Character'Pos ('0')),
            1 =>  Storage_Element'Val (Character'Pos ('1')),
            2 =>  Storage_Element'Val (Character'Pos ('2')),
            3 =>  Storage_Element'Val (Character'Pos ('3')),
            4 =>  Storage_Element'Val (Character'Pos ('4')),
            5 =>  Storage_Element'Val (Character'Pos ('5')),
            6 =>  Storage_Element'Val (Character'Pos ('6')),
            7 =>  Storage_Element'Val (Character'Pos ('7')),
            8 =>  Storage_Element'Val (Character'Pos ('8')),
            9 =>  Storage_Element'Val (Character'Pos ('9')),
            10 => Storage_Element'Val (Character'Pos ('A')),
            11 => Storage_Element'Val (Character'Pos ('B')),
            12 => Storage_Element'Val (Character'Pos ('C')),
            13 => Storage_Element'Val (Character'Pos ('D')),
            14 => Storage_Element'Val (Character'Pos ('E')),
            15 => Storage_Element'Val (Character'Pos ('F')));

      -------------
      -- To_Char --
      -------------

      function To_Char (Val : Storage_Element) return Storage_Element is
      begin
         case Val is
            when 0 .. 31 | 127 .. 255 =>
               return Storage_Element'Val (Character'Pos ('.'));
            when others =>
               return Val;
         end case;
      end To_Char;

      Cnt   : Storage_Count;
      Buffer : Storage_Array (1 .. 16);
      Last   : Storage_Count;

      --------------------
      -- Start_New_Line --
      --------------------

   begin

      Str (Str'Last) := Storage_Element'Val (Character'Pos (ASCII.LF));
      loop
         Src.Read (Buffer, Last);

         exit when Last < Buffer'First;

         Cnt := 0;

         for Elt of Buffer (Buffer'First .. Last) loop
            --  Hex
            Str (Str'First + Cnt * 3 + 0) := UInt4_To_Char (UInt4 (Shift_Right (Elt, 4)));
            Str (Str'First + Cnt * 3 + 1) := UInt4_To_Char (UInt4 (Elt and 16#0F#));

            --  ASCII
            Str (Str'Last - (16 - Cnt)) := To_Char (Elt);

            Cnt := Cnt + 1;
         end loop;

         if Cnt /= 0 then
            Dst.Write (Str, Last);
            if Last /= Str'Last then
               Success := False;
               return;
            end if;
         end if;

      end loop;

      Success := True;
   end Encode;

end Flux.Interfaces.Hexdump;
