package body Flux.Interfaces.As_Traits.Duplex is

   ----------
   -- Read --
   ----------

   overriding
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

   overriding
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

   overriding
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

   overriding
   procedure Write (This : in out Instance;
                    Data :        Storage_Array;
                    Last :    out Storage_Count)
   is
   begin
      This.Write (Data, Last);
   end Write;

end Flux.Interfaces.As_Traits.Duplex;
