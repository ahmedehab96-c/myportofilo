import './PortfolioBackground.css';

const LEFT = `Route::middleware('auth:sanctum')->group(function () {
  Route::get('/projects', [ProjectController::class, 'index']);
  Route::post('/tickets', [TicketController::class, 'store']);
});

// Keep the response small for mobile clients
return ProjectResource::collection(
  Project::with('tags')->latest()->paginate(20)
);

class TicketController extends Controller
{
  public function store(StoreTicketRequest $request)
  {
    $ticket = $request->user()->tickets()->create(
      $request->validated()
    );
    return new TicketResource($ticket);
  }
}`;

const RIGHT = `class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(project.title),
      onTap: () => context.push('/project/\${project.id}'),
    );
  }
}

// Refetch whenever the filter changes
export function useProjects(filter) {
  const [items, setItems] = useState([]);
  useEffect(() => {
    fetch(\`/api/projects?tag=\${filter}\`)
      .then((res) => res.json())
      .then(setItems);
  }, [filter]);
  return items;
}`;

const TOKENS = /(\/\/.*)|('[^']*'|`[^`]*`)|\b(class|extends|function|return|const|final|public|new|export|required|super)\b/g;

function highlight(code) {
  const parts = [];
  let last = 0;
  for (const m of code.matchAll(TOKENS)) {
    parts.push(code.slice(last, m.index));
    const kind = m[1] ? 'c' : m[2] ? 's' : 'k';
    parts.push(<span className={`pb-${kind}`} key={m.index}>{m[0]}</span>);
    last = m.index + m[0].length;
  }
  parts.push(code.slice(last));
  return parts;
}

// Rendered twice so the upward drift loops without a visible jump.
function CodeColumn({ code, side }) {
  const content = highlight(code);
  return (
    <div className={`pb-col pb-col-${side}`}>
      <div className="pb-track">
        <pre>{content}</pre>
        <pre>{content}</pre>
      </div>
    </div>
  );
}

/// Dot grid with real code drifting slowly along both edges of the page.
export default function PortfolioBackground() {
  return (
    <div className="portfolio-background" dir="ltr" aria-hidden="true">
      <CodeColumn code={LEFT} side="left" />
      <CodeColumn code={RIGHT} side="right" />
    </div>
  );
}
