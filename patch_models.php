<?php
$f = 'app/Models/Personnel.php';
$c = <<<EOT
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Personnel extends Model
{
    use HasFactory;

    protected \$fillable = [
        'prenom', 'nom', 'telephone', 'email', 'fonction', 'date_embauche', 'user_id', 'actif'
    ];

    public function user()
    {
        return \$this->belongsTo(User::class);
    }

    public function documents()
    {
        return \$this->morphMany(Document::class, 'documentable');
    }
}
EOT;
file_put_contents($f, $c);

$f2 = 'app/Models/Document.php';
$c2 = <<<EOT
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Document extends Model
{
    use HasFactory;

    protected \$fillable = [
        'nom', 'type_document', 'fichier_path', 'documentable_id', 'documentable_type', 'uploaded_by'
    ];

    public function documentable()
    {
        return \$this->morphTo();
    }

    public function uploader()
    {
        return \$this->belongsTo(User::class, 'uploaded_by');
    }
}
EOT;
file_put_contents($f2, $c2);

// Add morphMany to Enseignant
$f3 = 'app/Models/Enseignant.php';
$c3 = file_get_contents($f3);
$c3 = preg_replace('/\}\s*$/', "\n    public function documents()\n    {\n        return \$this->morphMany(Document::class, 'documentable');\n    }\n}", $c3);
file_put_contents($f3, $c3);
