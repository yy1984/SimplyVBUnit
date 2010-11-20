VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Tally"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
' Copyright 2010 Kelly Ethridge
'
' Licensed under the Apache License, Version 2.0 (the "License");
' you may not use this file except in compliance with the License.
' You may obtain a copy of the License at
'
'     http://www.apache.org/licenses/LICENSE-2.0
'
' Unless required by applicable law or agreed to in writing, software
' distributed under the License is distributed on an "AS IS" BASIS,
' WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
' See the License for the specific language governing permissions and
' limitations under the License.
'
' Module: Tally
'
Option Explicit

Private mCount As Long
Private mValue As Variant


Public Sub Init(ByRef Value As Variant)
    VariantCopyInd mValue, Value
End Sub

Public Function Equals(ByRef Other As Variant, ByVal Comparer As EqualityComparer) As Boolean
    Equals = Comparer.Equals(mValue, Other)
End Function


Public Property Get Count() As Long
    Count = mCount
End Property

Public Function Increment() As Long
    mCount = mCount + 1
    Increment = mCount
End Function

Public Function Decrement() As Long
    If mCount > 0 Then
        mCount = mCount - 1
    End If
    
    Decrement = mCount
End Function
