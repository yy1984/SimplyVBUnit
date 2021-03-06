VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Assertions"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'The MIT License (MIT)
'Copyright (c) 2012 Kelly Ethridge
'
'Permission is hereby granted, free of charge, to any person obtaining a copy
'of this software and associated documentation files (the "Software"), to deal
'in the Software without restriction, including without limitation the rights to
'use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
'the Software, and to permit persons to whom the Software is furnished to do so,
'subject to the following conditions:
'
'The above copyright notice and this permission notice shall be included in all
'copies or substantial portions of the Software.
'
'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
'INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
'PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
'FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
'OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
'DEALINGS IN THE SOFTWARE.
'
'
' Module: Assertions
'
Option Explicit

Public Enum AssertCode
    FailureCode = vbObjectError + 151000
    SuccessCode
    IgnoreCode
    
    #If False Then
        Dim FailureCode, SuccessCode, IgnoreCode
    #End If
End Enum

Public Sub Ignore(Optional ByRef Reason As String)
    Err.Raise AssertCode.IgnoreCode, , Reason
End Sub

Public Sub Fail(Optional ByRef Message As String)
    IncrementCount
    Err.Raise AssertCode.FailureCode, , Message
End Sub

Public Sub Pass(Optional ByRef Message As String)
    IncrementCount
    Err.Raise AssertCode.SuccessCode, , Message
End Sub

Public Sub IsTrue(ByVal Condition As Boolean, Optional ByRef Message As String)
    That Condition, Iz.True, Message
End Sub

Public Sub IsFalse(ByVal Condition As Boolean, Optional ByRef Message As String)
    That Condition, Iz.False, Message
End Sub

Public Sub IsVBEmpty(ByRef Actual As Variant, Optional ByRef Message As String)
    That Actual, Iz.vbEmpty, Message
End Sub

Public Sub IsNotVBEmpty(ByRef Actual As Variant, Optional ByRef Message As String)
    That Actual, Iz.Not.vbEmpty, Message
End Sub

Public Sub IsVBNull(ByRef Actual As Variant, Optional ByRef Message As String)
    That Actual, Iz.vbNull, Message
End Sub

Public Sub IsNotVBNull(ByRef Actual As Variant, Optional ByRef Message As String)
    That Actual, Iz.Not.vbNull, Message
End Sub

Public Sub IsMissing(ByRef Actual As Variant, Optional ByRef Message As String)
    That Actual, Iz.Missing, Message
End Sub

Public Sub IsNotMissing(ByRef Actual As Variant, Optional ByRef Message As String)
    That Actual, Iz.Not.Missing, Message
End Sub

Public Sub IsNothing(ByRef Actual As Variant, Optional ByRef Message As String)
    That Actual, Iz.Nothing, Message
End Sub

Public Sub IsNotNothing(ByRef Actual As Variant, Optional ByRef Message As String)
    That Actual, Iz.Not.Nothing, Message
End Sub

Public Sub AreEqual(ByRef Expected As Variant, ByRef Actual As Variant, Optional ByRef Message As String)
    That Actual, Iz.EqualTo(Expected), Message
End Sub

Public Sub AreNotEqual(ByRef Expected As Variant, ByRef Actual As Variant, Optional ByRef Message As String)
    That Actual, Iz.Not.EqualTo(Expected)
End Sub

Public Sub AreEqualFloats(ByRef Expected As Variant, ByRef Actual As Variant, Optional ByRef Tolerance As Variant, Optional ByRef Message As String)
    If VBA.IsMissing(Tolerance) Then
        That Actual, Iz.EqualTo(Actual), Message
    Else
        That Actual, Iz.EqualTo(Expected).Within(Tolerance), Message
    End If
End Sub

Public Sub AreNotEqualFloats(ByRef Expected As Variant, ByRef Actual As Variant, Optional ByRef Tolerance As Variant, Optional ByRef Message As String)
    If VBA.IsMissing(Tolerance) Then
        That Actual, Iz.Not.EqualTo(Actual), Message
    Else
        That Actual, Iz.Not.EqualTo(Expected).Within(Tolerance), Message
    End If
End Sub

Public Sub AreEqualStrings(ByRef Expected As String, ByRef Actual As String, Optional ByVal IgnoreCase As Boolean, Optional ByRef Message As String)
    If IgnoreCase Then
        That Actual, Iz.EqualTo(Expected).IgnoreCase, Message
    Else
        That Actual, Iz.EqualTo(Expected), Message
    End If
End Sub

Public Sub AreNotEqualStrings(ByRef Expected As String, ByRef Actual As String, Optional ByVal IgnoreCase As Boolean, Optional ByRef Message As String)
    If IgnoreCase Then
        That Actual, Iz.Not.EqualTo(Expected).IgnoreCase, Message
    Else
        That Actual, Iz.Not.EqualTo(Expected), Message
    End If
End Sub

Public Sub AreEquivalent(ByRef Expected As Variant, ByRef Actual As Variant, Optional ByRef Message As String)
    That Actual, Iz.EquivalentTo(Expected), Message
End Sub

Public Sub AreNotEquivalent(ByRef NotExpected As Variant, ByRef Actual As Variant, Optional ByRef Message As String)
    That Actual, Iz.[Not].EquivalentTo(NotExpected), Message
End Sub

Public Sub AreSame(ByVal Expected As Object, ByVal Actual As Object, Optional ByRef Message As String)
    That Actual, Iz.SameAs(Expected), Message
End Sub

Public Sub AreNotSame(ByVal Expected As Object, ByVal Actual As Object, Optional ByRef Message As String)
    That Actual, Iz.Not.SameAs(Expected), Message
End Sub

Public Sub Greater(ByRef Value1 As Variant, ByRef Value2 As Variant, Optional ByRef Message As String)
    That Value1, Iz.GreaterThan(Value2), Message
End Sub

Public Sub GreaterOrEqual(ByRef Value1 As Variant, ByRef Value2 As Variant, Optional ByRef Message As String)
    That Value1, Iz.GreaterThanOrEqualTo(Value2), Message
End Sub

Public Sub Less(ByRef Value1 As Variant, ByRef Value2 As Variant, Optional ByRef Message As String)
    That Value1, Iz.LessThan(Value2), Message
End Sub

Public Sub LessOrEqual(ByRef Value1 As Variant, ByRef Value2 As Variant, Optional ByRef Message As String)
    That Value1, Iz.LessThanOrEqualTo(Value2), Message
End Sub

Public Sub IsEmpty(ByRef Value As Variant, Optional ByRef Message As String)
    That Value, Iz.Empty, Message
End Sub

Public Sub Ordered(ByRef Value As Variant, Optional ByRef Message As String)
    That Value, Iz.Ordered, Message
End Sub

Public Sub OrderedDescending(ByRef Value As Variant, Optional ByRef Message As String)
    That Value, Iz.Ordered.Descending, Message
End Sub

Public Sub InRange(ByRef Value As Variant, ByRef FromValue As Variant, ByRef ToValue As Variant, Optional ByRef Message As String)
    That Value, Iz.InRange(FromValue, ToValue), Message
End Sub

Public Sub NotInRange(ByRef Value As Variant, ByRef FromValue As Variant, ByRef ToValue As Variant, Optional ByRef Message As String)
    That Value, Iz.Not.InRange(FromValue, ToValue), Message
End Sub

Public Sub Unique(ByRef Value As Variant, Optional ByRef Message As String)
    That Value, Iz.Unique, Message
End Sub

Public Sub NotUnique(ByRef Value As Variant, Optional ByRef Message As String)
    That Value, Iz.Not.Unique, Message
End Sub

Public Sub That(ByRef Actual As Variant, ByVal Constraint As Object, Optional ByRef Message As String)
    Dim ResolvedConstraint As IConstraint
    
    If TypeOf Constraint Is IResolvable Then
        Dim Resolvable As IResolvable
        Set Resolvable = Constraint
        Set ResolvedConstraint = Resolvable.Resolve
    Else
        Set ResolvedConstraint = Constraint
    End If
    
    If ResolvedConstraint.Matches(Actual) Then
        IncrementCount
    Else
        Dim Writer As New TextMessageWriter
        
        If Len(Message) > 0 Then
            Writer.WriteLine Message
        End If
        
        ResolvedConstraint.WriteMessageTo Writer
        Fail Writer.ToString
    End If
End Sub

Public Sub Throws(ByVal Number As Long, Optional ByRef Source As String, Optional ByRef Description As String)
    Dim Info        As ErrorInfo
    Dim Constraint  As ThrowsConstraint
    
    Set Info = Sim.NewErrorInfo(Number, Source, Description)
    Set Constraint = Sim.NewThrowsConstraint(Info)
    
    Set TestContext.Throws = Constraint
End Sub


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'   Private Helpers
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Private Sub IncrementCount()
    TestContext.IncrementAssertCount
End Sub


