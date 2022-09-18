package body Flux.Interfaces.As_Traits.Duplex is

   ----------
   -- Read --
   ----------

   procedure Read (This    : in out Instance;
                   Data    :    out Storage_Element;
                   Success :    out Boolean)
   is
   begin
      This.Read (Data, Success);
   end Read;

   ----------
   -- Read --
   ----------

   procedure Read (This : in out Instance;
                   Data :    out Storage_Array;
                   Last :    out Storage_Count)
   is
   begin
      This.Read (Data, Last);
   end Read;

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

end Flux.Interfaces.As_Traits.Duplex;
