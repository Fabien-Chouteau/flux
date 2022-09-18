package body Flux.Interfaces.Bounded_Array.Sink is

   -----------
   -- Write --
   -----------

   overriding
   procedure Write (This    : in out Instance;
                    Data    :        Storage_Element;
                    Success :    out Boolean)
   is
   begin
      if This.Next in This.Data'Range then
         This.Data (This.Next) := Data;
         This.Next := This.Next + 1;
         Success := True;
      else
         Success := False;
      end if;
   end Write;

   -----------
   -- Write --
   -----------

   overriding
   procedure Write (This : in out Instance;
                    Data :        Storage_Array;
                    Last :    out Storage_Count)
   is
      Avail : constant Storage_Count := This.Data'Last - This.Next + 1;
   begin
      if Avail > 0 then
         This.Data (This.Next .. This.Next + Avail - 1)
           := Data (Data'First .. Data'First + Avail - 1);
         This.Next := This.Next + Avail;
      end if;

      Last := Data'First + Avail - 1;
   end Write;

end Flux.Interfaces.Bounded_Array.Sink;
