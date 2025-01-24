package body Flux.Traits.Bounded_Array_Source is

   pragma Warnings (Off, "formal parameter * is not modified");

   ----------
   -- Read --
   ----------

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

   -------------------
   -- Seek_Relative --
   -------------------

   procedure Seek_Relative (This    : in out Instance;
                            Offset  :        Storage_Count;
                            Data    :    out Storage_Element;
                            Success :    out Boolean)
   is
      Target : constant Storage_Offset := This.Next + Offset;
   begin
      if Target in This.Data'Range then
         Data := This.Data (Target);
         Success := True;
      else
         Success := False;
      end if;

   end Seek_Relative;

   -------------------
   -- Seek_Relative --
   -------------------

   procedure Seek_Relative (This    : in out Instance;
                            Offset  :        Storage_Count;
                            Data    :    out Storage_Array;
                            Last    :    out Storage_Count)
   is
      Target : constant Storage_Offset := This.Next + Offset;

      Avail : constant Storage_Count :=
        Storage_Count'Min (This.Data'Last - Target + 1, Data'Length);
   begin
      if Avail > 0 then
         Data (Data'First .. Data'First + Avail - 1) :=
           This.Data (Target .. Target + Avail - 1);
      end if;

      Last := Data'First + Avail - 1;
   end Seek_Relative;

   -------------
   -- Consume --
   -------------

   procedure Consume (This  : in out Instance;
                      Count :        Storage_Count)
   is
   begin
      This.Next := This.Next + Count;
   end Consume;

end Flux.Traits.Bounded_Array_Source;
