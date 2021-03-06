VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "MovieListComparer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'
' MovieListComparer
'
Option Explicit
Implements IEqualityComparer


Public Function Equals(ByVal X As MovieList, ByVal Y As MovieList) As Long
    Equals = X.Equals(Y)
End Function

Private Function IEqualityComparer_Equals(X As Variant, Y As Variant) As Boolean
    IEqualityComparer_Equals = Equals(X, Y)
End Function
