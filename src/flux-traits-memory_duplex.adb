package body Flux.Traits.Memory_Duplex is

   procedure Reset (This : in out Instance) is
   begin
      This.Next_In := 1;
      This.Next_Out := 1;
   end Reset;

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
      if This.Next_In in Dst_Data'Range then
         Dst_Data (This.Next_In) := Data;
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
      Dst_Data : Storage_Array (1 .. This.Len)
        with Address => This.Base;

      Avail : constant Storage_Count :=
        Storage_Count'Min (Dst_Data'Last - This.Next_In + 1, Data'Length);
   begin
      if Avail > 0 then
         Dst_Data (This.Next_In .. This.Next_In + Avail - 1)
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
      Src_Data : Storage_Array (1 .. This.Len)
        with Address => This.Base;
   begin
      if This.Next_Out in Src_Data'Range then
         Data := Src_Data (This.Next_Out);
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
      Src_Data : Storage_Array (1 .. This.Len)
        with Address => This.Base;

      Avail : constant Storage_Count :=
        Storage_Count'Min (Src_Data'Last - This.Next_Out + 1, Data'Length);
   begin
      if Avail > 0 then
         Data (Data'First .. Data'First + Avail - 1) :=
           Src_Data (This.Next_Out .. This.Next_Out + Avail - 1);
         This.Next_Out := This.Next_Out + Avail;
      end if;

      Last := Data'First + Avail - 1;
   end Read;

end Flux.Traits.Memory_Duplex;
