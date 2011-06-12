#tag ClassClass NSIndexSetInherits NSObject	#tag Method, Flags = &h0		Function Operator_Convert() As Integer()		  #if targetCocoa		    declare function getIndexes lib CocoaLib selector "getIndexes:indexBuffer:inIndexRange" (obj_id as Ptr, indexBuffer as Ptr, bufferSize as Integer, indexRangePointer as Ptr) as Integer		    		    if self.id <> nil then		      const sizeOfNSUInteger = 4		      dim indexBuffer as new MemoryBlock(sizeOfNSUInteger*self.Count)		      dim indexCount as Integer = getIndexes(self, indexBuffer, self.Count, nil)		      dim L() as Integer		      dim offset as Integer = 0		      while offset < indexBuffer.Size		        L.Append indexBuffer.Long(0)		        offset = offset + sizeOfNSUInteger		      wend		      return L		    else		      dim L(-1) as Integer		      return L		    end if		  #endif		End Function	#tag EndMethod	#tag ComputedProperty, Flags = &h0		#tag Getter			Get			  #if targetCocoa			    declare function count lib CocoaLib selector "count" (obj_id as Ptr) as Integer			    			    return count(self)			  #endif			End Get		#tag EndGetter		Count As Integer	#tag EndComputedProperty	#tag ComputedProperty, Flags = &h0		#tag Getter			Get			  #if targetCocoa			    declare function firstIndex lib CocoaLib selector "firstIndex" (obj_id as Ptr) as Integer			    			    return firstIndex(self)			  #endif			End Get		#tag EndGetter		FirstIndex As Integer	#tag EndComputedProperty	#tag ComputedProperty, Flags = &h0		#tag Getter			Get			  #if targetCocoa			    declare function lastIndex lib CocoaLib selector "lastIndex" (obj_id as Ptr) as Integer			    			    return lastIndex(self)			  #endif			End Get		#tag EndGetter		LastIndex As Integer	#tag EndComputedPropertyEnd Class#tag EndClass