package body Flux.Traits.Memory_Sink is

   -----------
   -- Write --
   -----------

   procedure Write (This    : in out Instance;
                    Data    :        Storage_Element;
                    Success :    out Boolean)
   is
      Dst_Data : Storage_Array (1 .. This.Len)
        with Address => This.Base;
   begin
      if This.Next in Dst_Data'Range then
         Dst_Data (This.Next) := Data;
         This.Next := This.Next + 1;
         Success := True;
      else
         Success := False;
      end if;
   end Write;

   -----------
   -- Write --
   -----------

   procedure Write (This : in out Instance;
                    Data :        Storage_Array;
                    Last :    out Storage_Count)
   is
      Dst_Data : Storage_Array (1 .. This.Len)
        with Address => This.Base;

      Avail : constant Storage_Count :=
        Storage_Count'Min (Dst_Data'Last - This.Next + 1, Data'Length);
   begin
      if Avail > 0 then
         Dst_Data (This.Next .. This.Next + Avail - 1)
           := Data (Data'First .. Data'First + Avail - 1);
         This.Next := This.Next + Avail;
      end if;

      Last := Data'First + Avail - 1;
   end Write;

end Flux.Traits.Memory_Sink;
