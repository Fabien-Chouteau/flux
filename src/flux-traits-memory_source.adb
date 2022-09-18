package body Flux.Traits.Memory_Source is

   ----------
   -- Read --
   ----------

   procedure Read (This    : in out Instance;
                   Data    :    out Storage_Element;
                   Success :    out Boolean)
   is
      Src_Data : Storage_Array (1 .. This.Len)
        with Address => This.Base;
   begin
      if This.Next in Src_Data'Range then
         Data := Src_Data (This.Next);
         This.Next := This.Next + 1;
         Success := True;
      else
         Success := False;
      end if;
   end Read;

   ----------
   -- Read --
   ----------

   procedure Read (This : in out Instance;
                   Data :    out Storage_Array;
                   Last :    out Storage_Count)
   is
      Src_Data : Storage_Array (1 .. This.Len)
        with Address => This.Base;

      Avail : constant Storage_Count :=
        Storage_Count'Min (Src_Data'Last - This.Next + 1, Data'Length);
   begin
      if Avail > 0 then
         Data (Data'First .. Data'First + Avail - 1) :=
           Src_Data (This.Next .. This.Next + Avail - 1);
         This.Next := This.Next + Avail;
      end if;

      Last := Data'First + Avail - 1;
   end Read;

end Flux.Traits.Memory_Source;
