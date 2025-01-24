with GNAT.OS_Lib; use GNAT.OS_Lib;

package body Flux.Traits.File_IO.Sink is

   pragma Warnings (Off, "formal parameter * is not modified");

   -----------
   -- Write --
   -----------

   procedure Write (This    : in out GNAT.OS_Lib.File_Descriptor;
                    Data    :        Storage_Element;
                    Success :    out Boolean)
   is
      Count : Integer;
   begin
      if This = Invalid_FD then
         Success := False;
         return;
      end if;

      Count := GNAT.OS_Lib.Write (FD => This,
                                  A  => Data'Address,
                                  N  => 1);
      Success := Count = 1;
   end Write;

   -----------
   -- Write --
   -----------

   procedure Write (This : in out GNAT.OS_Lib.File_Descriptor;
                    Data :        Storage_Array;
                    Last :    out Storage_Count)
   is
      Count : Integer;
   begin
      if This = Invalid_FD then
         Last := Data'First - 1;
         return;
      end if;

      Count := GNAT.OS_Lib.Write (FD => This,
                                  A  => Data'Address,
                                  N  => Data'Length);
      Last := Data'First + Storage_Count (Count) - 1;
   end Write;

end Flux.Traits.File_IO.Sink;
