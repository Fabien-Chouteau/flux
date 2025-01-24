package body Flux.Interfaces.As_Traits.Source is

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

end Flux.Interfaces.As_Traits.Source;
