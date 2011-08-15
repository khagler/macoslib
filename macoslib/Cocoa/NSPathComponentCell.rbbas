#tag Class
Class NSPathComponentCell
	#tag Method, Flags = &h0
		Sub Constructor(object_id as Ptr)
		  me.id = object_id
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(obj as NSPathComponentCell) As Integer
		  if obj.id = nil then
		    return 1
		  else
		    return Integer(me.id) - Integer(obj.id)
		  end if
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private id As Ptr
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #if targetCocoa
			    if me.id <> nil then
			      soft declare function getURL lib Cocoa selector "URL" (id as Ptr) as Ptr
			      
			      dim p as Ptr = getURL(me.id)
			      if p <> nil then
			        soft declare function absoluteString lib Cocoa selector "absoluteString" (id as Ptr) as CFStringRef
			        return absoluteString(p)
			      else
			        return ""
			      end if
			    else
			      return ""
			    end if
			  #endif
			  
			End Get
		#tag EndGetter
		URL As String
	#tag EndComputedProperty


	#tag Constant, Name = Cocoa, Type = String, Dynamic = False, Default = \"Cocoa.framework", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="URL"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
