with GNAT.OS_Lib; use GNAT.OS_Lib;

package body Flux.Interfaces.File_IO.Sink is

   ------------
   -- Create --
   ------------

   function Create (Path : String) return Instance is
   begin
      return Result : Instance do
         Result.FD := GNAT.OS_Lib.Open_Append (Path, GNAT.OS_Lib.Binary);
      end return;
   end Create;

   ------------
   -- Create --
   ------------

   function Create (FD : GNAT.OS_Lib.File_Descriptor) return Instance is
   begin
      return Result : Instance do
         Result.FD := FD;
      end return;
   end Create;

   ----------
   -- Open --
   ----------

   function Open (This : Instance) return Boolean
   is (This.FD /= GNAT.OS_Lib.Invalid_FD);

   -----------
   -- Close --
   -----------

   procedure Close (This : Instance) is
   begin
      if This.Open then
         GNAT.OS_Lib.Close (This.FD);
      end if;
   end Close;

   -----------
   -- Write --
   -----------

   overriding
   procedure Write (This    : in out Instance;
                    Data    :        Storage_Element;
                    Success :    out Boolean)
   is
      Count : Integer;
   begin
      if not This.Open then
         Success := False;
         return;
      end if;

      Count := GNAT.OS_Lib.Write (FD =>  This.FD,

                                  A =>  Data'Address,
                                  N =>  1);
      Success := Count = 1;
   end Write;

   -----------
   -- Write --
   -----------

   overriding
   procedure Write (This : in out Instance;
                    Data :        Storage_Array;
                    Last :    out Storage_Count)
   is
      Count : Integer;
   begin
      if not This.Open then
         Last := Data'First - 1;
         return;
      end if;

      Count := GNAT.OS_Lib.Write (FD =>  This.FD,
                                  A =>  Data'Address,
                                  N =>  Data'Length);
      Last := Data'First + Storage_Count (Count) - 1;
   end Write;

end Flux.Interfaces.File_IO.Sink;
