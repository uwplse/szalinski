#include <CGAL/Exact_predicates_inexact_constructions_kernel.h>
#include <CGAL/Polyhedron_items_with_id_3.h>
#include <CGAL/Polyhedron_3.h>
#include <CGAL/Surface_mesh.h>
#include <CGAL/Polygon_mesh_processing/corefinement.h>
#include <CGAL/Polygon_mesh_processing/distance.h>
#include <CGAL/Polygon_mesh_processing/remesh.h>

#include <CGAL/IO/OFF_reader.h>

#if defined(CGAL_LINKED_WITH_TBB)
#define TAG CGAL::Parallel_tag
#else
#define TAG CGAL::Sequential_tag
#endif

typedef CGAL::Exact_predicates_inexact_constructions_kernel K;
typedef CGAL::Polyhedron_3<K, CGAL::Polyhedron_items_with_id_3>  Polyhedron;
typedef K::Point_3                     Point;
typedef CGAL::Surface_mesh<K::Point_3> Mesh;

namespace PMP = CGAL::Polygon_mesh_processing;

int main(int argc, char* argv[])
{
  if (argc < 3) {
    std::cerr << "Needs two meshes, -v for volume, -h for haussdorf" << std::endl;
    return 1;
  }

  const char* f1  = argv[1];
  const char* f2  = argv[2];
  const char* f3  = argv[3];

  Mesh tm1, tm2;
  std::ifstream i1(f1);
  i1 >> tm1;
  std::ifstream i2(f2);
  i2 >> tm2;


  if(!i1 || !i2)
  {
    std::cerr << "Cannot open files " << std::endl;
    return EXIT_FAILURE;
  }

  if (strcmp(f3, "-v") == 0) {
    Mesh diff;
    CGAL::Polygon_mesh_processing::corefine_and_compute_difference(tm1, tm2, diff);
    double v1 = CGAL::Polygon_mesh_processing::volume(tm1);
    double v2 = CGAL::Polygon_mesh_processing::volume(tm2);
    double v_diff = CGAL::Polygon_mesh_processing::volume(diff);
    double normalized_v_diff = v_diff / std::max(v1, v2);
    std::cout<<normalized_v_diff<<std::endl;
  } else if (strcmp(f3, "-h") == 0) {
    if (argc < 5) {
      std::cout << "Pass a number after h" << std::endl;
      exit(1);
    }
    int n = std::stoi(argv[4]);
    double d = CGAL::Polygon_mesh_processing::approximate_Hausdorff_distance<TAG>
      (tm1,
       tm2,
       PMP::parameters::number_of_points_on_edges(n),
       PMP::parameters::number_of_points_on_faces(n)
       );
    std::cout << d << std::endl;
  } else {
    std::cout << "Invalid arg" << std::endl;
    exit(1);
  }
}
