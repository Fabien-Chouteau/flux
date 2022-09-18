package body Flux.Interfaces.As_Traits.Sink is

   -----------
   -- Write --
   -----------

   procedure Write (This    : in out Instance;
                    Data    :        Storage_Element;
                    Success :    out Boolean)
   is
   begin
      This.Write (Data, Success);
   end Write;

   -----------
   -- Write --
   -----------

   procedure Write (This : in out Instance;
                    Data :        Storage_Array;
                    Last :    out Storage_Count)
   is
   begin
      This.Write (Data, Last);
   end Write;

end Flux.Interfaces.As_Traits.Sink;
