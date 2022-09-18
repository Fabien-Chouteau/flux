
package body Flux.Slice is

   ------------
   -- Create --
   ------------

   function Create (Addr : System.Address;
                    Size : Storage_Count)
                    return Instance
   is
   begin
      if Size = 0 then
         return Result : Instance do
            Result.First := 1;
            Result.Last := 0;
         end return;
      else
         return Result : Instance do
            Result.First := To_Integer (Addr);
            Result.Last := Integer_Address
              (Storage_Count (Result.First) + Size - 1);
         end return;
      end if;
   end Create;

   -----------------------
   -- Create_From_Array --
   -----------------------

   function Create_From_Array (A : aliased Arr) return Instance
   is (Create (A'Address, A'Size / System.Storage_Unit));

   ------------------
   -- First_Cursor --
   ------------------

   function First_Cursor (This : Instance) return Cursor
   is ((Addr => This.First));

   -------------
   -- Advance --
   -------------

   function Advance (This : Instance; Position : Cursor) return Cursor is
      pragma Unreferenced (This);
   begin
      return (Addr => Position.Addr + 1);
   end Advance;

   ------------------------
   -- Cursor_Has_Element --
   ------------------------

   function Cursor_Has_Element (This : Instance;
                                Position : Cursor)
                                return Boolean
   is (Position.Addr in This.First .. This.Last);

   -----------------
   -- Get_Element --
   -----------------

   function Get_Element (This : Instance;
                         Position : Cursor)
                         return Storage_Element
   is
      pragma Unreferenced (This);

      Data : Storage_Element
        with Import, Address => To_Address (Position.Addr);
   begin
      return Data;
   end Get_Element;

end Flux.Slice;
