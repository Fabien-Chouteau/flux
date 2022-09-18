with System;
with System.Storage_Elements; use System.Storage_Elements;

package Flux.Slice
with Preelaborate
is

   type Instance is tagged limited private
     with Iterable => (First       => First_Cursor,
                       Next        => Advance,
                       Has_Element => Cursor_Has_Element,
                       Element     => Get_Element);

   function Create (Addr : System.Address;
                    Size : Storage_Count)
                    return Instance;

   generic
      type Index_Type is (<>);
      type Element_Type is limited private;
      type Arr is array (Index_Type) of Element_Type;
   function Create_From_Array (A : aliased Arr) return Instance;

   -- Iterable --

   type Cursor is private;

   function First_Cursor (This : Instance) return Cursor;

   function Advance (This : Instance; Position : Cursor) return Cursor;

   function Cursor_Has_Element (This : Instance; Position : Cursor)
                                return Boolean;

   function Get_Element (This : Instance; Position : Cursor)
                         return Storage_Element;

private

   type Cursor is record
      Addr : System.Storage_Elements.Integer_Address;
   end record;

   type Instance is tagged limited record
      First : System.Storage_Elements.Integer_Address;
      Last  : System.Storage_Elements.Integer_Address;
   end record;

end Flux.Slice;
