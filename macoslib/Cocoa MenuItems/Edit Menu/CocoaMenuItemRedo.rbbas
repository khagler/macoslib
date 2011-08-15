#tag Class
Protected Class CocoaMenuItemRedo
Inherits CocoaMenuItem
	#tag Event
		Function ActionSelectorName() As String
		  return "redo:"
		End Function
	#tag EndEvent

	#tag Event
		Sub EnableMenu(target as Ptr)
		  #if targetCocoa
		    declare function respondsToSelector lib CocoaLib selector "respondsToSelector:" (obj_id as Ptr, aSelector as Ptr) as Boolean
		    declare function undoManager lib CocoaLib selector "undoManager" (obj_id as Ptr) as Ptr
		    declare function canRedo lib CocoaLib selector "canRedo" (obj_id as Ptr) as Boolean
		    
		    if respondsToSelector(target, Cocoa.NSSelectorFromString("undoManager")) then
		      dim undoMgr as Ptr = undoManager(target)
		      self.Enabled = canRedo(undoMgr)
		    else
		      self.Enabled = false
		    end if
		  #endif
		  
		End Sub
	#tag EndEvent


	#tag Constant, Name = LocalizedText, Type = String, Dynamic = True, Default = \"Redo", Scope = Public
		#Tag Instance, Platform = Any, Language = en, Definition  = \"Redo"
		#Tag Instance, Platform = Any, Language = de, Definition  = \"Wiederholen"
		#Tag Instance, Platform = Any, Language = ja, Definition  = \"\xE3\x82\x84\xE3\x82\x8A\xE7\x9B\xB4\xE3\x81\x99"
		#Tag Instance, Platform = Any, Language = fr, Definition  = \"R\xC3\xA9tablir"
		#Tag Instance, Platform = Any, Language = it, Definition  = \"Ripristina"
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="AutoEnable"
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			InheritedFrom="MenuItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Checked"
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			InheritedFrom="MenuItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CommandKey"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="MenuItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			InheritedFrom="MenuItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Icon"
			Group="Behavior"
			InitialValue="0"
			Type="Picture"
			InheritedFrom="MenuItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			InheritedFrom="MenuItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="KeyboardShortcut"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="MenuItem"
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
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="MenuItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Text"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="MenuItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			InheritedFrom="MenuItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_mIndex"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="MenuItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_mName"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="MenuItem"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
