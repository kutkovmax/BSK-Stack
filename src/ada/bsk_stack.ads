generic
   type Element_Type is private;
package BSK_Stack is
   procedure Push(S : in out Ada.Containers.Vectors.Vector(Element_Type); V : Element_Type);
   function Pop(S : in out Ada.Containers.Vectors.Vector(Element_Type)) return Element_Type;
   procedure Update_Colors(S : in out Ada.Containers.Vectors.Vector(Element_Type));
end BSK_Stack;
-- Implementation would use a record Color + Value; omitted for brevity.