package body Flux.Interfaces.Bounded_Array.Source is

   ----------
   -- Read --
   ----------

   overriding
   procedure Read (This    : in out Instance;
                   Data    :    out Storage_Element;
                   Success :    out Boolean)
   is
   begin
      if This.Next in This.Data'Range then
         Data := This.Data (This.Next);
         This.Next := This.Next + 1;
         Success := True;
      else
         Success := False;
      end if;
   end Read;

   ----------
   -- Read --
   ----------

   overriding
   procedure Read (This : in out Instance;
                   Data :    out Storage_Array;
                   Last :    out Storage_Count)
   is
      Avail : constant Storage_Count :=
        Storage_Count'Min (This.Data'Last - This.Next + 1, Data'Length);
   begin
      if Avail > 0 then
         Data (Data'First .. Data'First + Avail - 1) :=
           This.Data (This.Next .. This.Next + Avail - 1);
         This.Next := This.Next + Avail;
      end if;

      Last := Data'First + Avail - 1;
   end Read;

end Flux.Interfaces.Bounded_Array.Source;
