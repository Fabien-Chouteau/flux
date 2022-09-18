package body Flux.Traits.Bounded_Array_Duplex is

   procedure Reset (This : in out Instance) is
   begin
      This.Next_In := This.Data'First;
      This.Next_Out := This.Data'First;
   end Reset;

   -----------
   -- Write --
   -----------

   procedure Write (This    : in out Instance;
                    Data    :        Storage_Element;
                    Success :    out Boolean)
   is
   begin
      if This.Next_In in This.Data'Range then
         This.Data (This.Next_In) := Data;
         This.Next_In := This.Next_In + 1;
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
      Avail : constant Storage_Count :=
        Storage_Count'Min (This.Data'Last - This.Next_In + 1, Data'Length);
   begin
      if Avail > 0 then
         This.Data (This.Next_In .. This.Next_In + Avail - 1)
           := Data (Data'First .. Data'First + Avail - 1);
         This.Next_In := This.Next_In + Avail;
      end if;

      Last := Data'First + Avail - 1;
   end Write;

      ----------
   -- Read --
   ----------

   procedure Read (This    : in out Instance;
                   Data    :    out Storage_Element;
                   Success :    out Boolean)
   is
   begin
      if This.Next_Out in This.Data'Range then
         Data := This.Data (This.Next_Out);
         This.Next_Out := This.Next_Out + 1;
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
        Storage_Count'Min (This.Data'Last - This.Next_Out + 1, Data'Length);
   begin
      if Avail > 0 then
         Data (Data'First .. Data'First + Avail - 1) :=
           This.Data (This.Next_Out .. This.Next_Out + Avail - 1);
         This.Next_Out := This.Next_Out + Avail;
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
      Target : constant Storage_Offset := This.Next_Out + Offset;
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
      Target : constant Storage_Offset := This.Next_Out + Offset;

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
      This.Next_Out := This.Next_Out + Count;
   end Consume;

end Flux.Traits.Bounded_Array_Duplex;
