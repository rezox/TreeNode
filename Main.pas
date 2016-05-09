unit Main;

interface //#################################################################### ��

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Layouts, FMX.TreeView, FMX.StdCtrls, FMX.Controls.Presentation,
  LUX, LUX.Graph, LUX.Graph.Tree;

type
  TForm1 = class(TForm)
    TreeView1: TTreeView;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { private �錾 }
    procedure ShowTree;
  public
    { public �錾 }
    _Root :TTreeNode;
    ///// ���\�b�h
    procedure AddNode( const N_:Integer );
    procedure DelNode( const N_:Integer );
  end;

var
  Form1: TForm1;

implementation //############################################################### ��

{$R *.fmx}

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

procedure TForm1.ShowTree;
//-----------------------
     procedure AddNode( const Parent_:TFmxObject; const TreeNode_:TTreeNode );
     var
        I :Integer;
        P :TTreeViewItem;
     begin
          P := TTreeViewItem.Create( Self );

          P.Parent := Parent_;
          P.Text   := 'Order = ' + TreeNode_.Order.ToString + ' : '
                    + 'ChildsN = ' + TreeNode_.ChildsN.ToString;

          with TreeNode_ do
          begin
               for I := 0 to ChildsN-1 do AddNode( P, Childs[ I ] );
          end;
     end;
//-----------------------
begin
     TreeView1.Clear;

     AddNode( TreeView1, _Root );

     TreeView1.ExpandAll;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

procedure TForm1.AddNode( const N_:Integer );
var
   N :Integer;
   P :TTreeNode;
begin
     for N := 1 to N_ do
     begin
          P := _Root;

          while P.ChildsN > 0 do
          begin
               if Random( 5 ) = 0 then Break;

               P := P.Childs[ Random( P.ChildsN ) ];
          end;

          TTreeNode.Create( P );
     end;

     ShowTree;
end;

procedure TForm1.DelNode( const N_:Integer );
var
   N :Integer;
   P :TTreeNode;
begin
     if _Root.ChildsN = 0 then Exit;

     for N := 1 to N_ do
     begin
          P := _Root.Childs[ Random( _Root.ChildsN ) ];

          while P.ChildsN > 0 do
          begin
               P := P.Childs[ Random( P.ChildsN ) ];
          end;

          P.Free;
     end;

     ShowTree;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

procedure TForm1.FormCreate(Sender: TObject);
begin
     _Root := TTreeNode.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     _Root.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     AddNode( 10 );
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     DelNode( 10 );
end;

end. //######################################################################### ��
